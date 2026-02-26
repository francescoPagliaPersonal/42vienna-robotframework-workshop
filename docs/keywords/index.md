# Keyword Documentation

This section contains auto-generated documentation for all resource files in this workshop.
The documentation is generated using Robot Framework's `libdoc` tool.

## Resource Files

| Resource | Description |
|----------|-------------|
| [Common](common.md) | Shared setup/teardown and variables |
| [Login Page](login_page.md) | Login page keywords |
| [Products Page](products_page.md) | Products/inventory page keywords |
| [Cart Page](cart_page.md) | Shopping cart keywords |
| [Checkout Page](checkout_page.md) | Checkout flow keywords |

## How Keywords Work

In Robot Framework, **keywords** are reusable building blocks — like functions in programming.
Resource files group related keywords together following the **page object pattern**:

- Each page of the application gets its own resource file
- Keywords abstract away CSS selectors and DOM interactions
- Tests use descriptive keyword names instead of raw selectors

```
Test Case → Keywords (resource file) → Browser Library → Playwright → Browser
```
