# Login Page Keywords

_Keywords for interacting with the SauceDemo login page._

**Source:** `resources/login_page.resource`

## Keywords (3)

### Login Should Fail With Message

Verify that an error message is displayed on the login page.

**Arguments:**

| Name | Type | Default |
|------|------|---------|
| `expected_message` |  | _required_ |

---

### Login Should Succeed

Verify that the user has been redirected to the products page after login.

---

### Login With Credentials

Fill in username and password, then click the login button.

**Arguments:**

| Name | Type | Default |
|------|------|---------|
| `username` |  | _required_ |
| `password` |  | _required_ |

---
