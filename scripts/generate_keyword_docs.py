#!/usr/bin/env python3
"""Generate Markdown keyword documentation from Robot Framework resource files.

Uses libdoc JSON output to create Markdown pages suitable for MkDocs.
Run from the project root: uv run python scripts/generate_keyword_docs.py
"""
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
RESOURCES_DIR = PROJECT_ROOT / "resources"
OUTPUT_DIR = PROJECT_ROOT / "docs" / "keywords"

# Resource files to document (skip saucedemo.resource as it's just imports)
RESOURCE_FILES = [
    ("common.resource", "Common Keywords"),
    ("login_page.resource", "Login Page Keywords"),
    ("products_page.resource", "Products Page Keywords"),
    ("cart_page.resource", "Cart Page Keywords"),
    ("checkout_page.resource", "Checkout Page Keywords"),
]


def run_libdoc_json(resource_path: Path) -> dict:
    """Run libdoc to generate JSON output for a resource file."""
    with tempfile.NamedTemporaryFile(suffix=".json", delete=False) as tmp:
        tmp_path = tmp.name
    try:
        result = subprocess.run(
            [sys.executable, "-m", "robot.libdoc", str(resource_path), tmp_path],
            capture_output=True,
            text=True,
        )
        if result.returncode != 0:
            print(f"  Warning: libdoc failed for {resource_path.name}: {result.stderr.strip()}")
            return {}
        return json.loads(Path(tmp_path).read_text())
    finally:
        Path(tmp_path).unlink(missing_ok=True)


def strip_html(text: str) -> str:
    """Remove HTML tags from text."""
    return re.sub(r"<[^>]+>", "", text).strip()


def generate_markdown(libdoc_data: dict, title: str, resource_name: str) -> str:
    """Convert libdoc JSON data to a Markdown page."""
    lines = [f"# {title}", ""]

    # Resource documentation
    doc = strip_html(libdoc_data.get("doc", "")).strip()
    if doc:
        lines.append(f"_{doc}_")
        lines.append("")

    lines.append(f"**Source:** `resources/{resource_name}`")
    lines.append("")

    # Variables section
    # libdoc doesn't export variables, but we note them for reference

    # Keywords section
    keywords = libdoc_data.get("keywords", [])
    if not keywords:
        lines.append("_No keywords defined in this resource._")
        return "\n".join(lines)

    lines.append(f"## Keywords ({len(keywords)})")
    lines.append("")

    for kw in keywords:
        name = kw.get("name", "Unknown")
        kw_doc = strip_html(kw.get("doc", "")).strip()
        args = kw.get("args", [])

        lines.append(f"### {name}")
        lines.append("")

        if kw_doc:
            lines.append(kw_doc)
            lines.append("")

        # Arguments
        if args:
            lines.append("**Arguments:**")
            lines.append("")
            lines.append("| Name | Type | Default |")
            lines.append("|------|------|---------|")
            for arg in args:
                arg_name = arg.get("name", "")
                arg_type = arg.get("type", "")
                arg_default = arg.get("defaultValue", "")
                if arg_type:
                    type_str = f"`{arg_type}`"
                else:
                    type_str = ""
                if arg_default:
                    default_str = f"`{arg_default}`"
                else:
                    default_str = "_required_"
                lines.append(f"| `{arg_name}` | {type_str} | {default_str} |")
            lines.append("")

        lines.append("---")
        lines.append("")

    return "\n".join(lines)


def main():
    """Generate keyword documentation for all resource files."""
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    print("Generating keyword documentation...")
    for resource_name, title in RESOURCE_FILES:
        resource_path = RESOURCES_DIR / resource_name
        if not resource_path.exists():
            print(f"  Skipping {resource_name} (not found)")
            continue

        print(f"  Processing {resource_name}...")
        libdoc_data = run_libdoc_json(resource_path)
        if not libdoc_data:
            continue

        md_content = generate_markdown(libdoc_data, title, resource_name)
        output_file = OUTPUT_DIR / resource_name.replace(".resource", ".md")
        output_file.write_text(md_content)
        print(f"    -> {output_file.relative_to(PROJECT_ROOT)}")

    print("Done.")


if __name__ == "__main__":
    main()
