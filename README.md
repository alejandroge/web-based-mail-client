# README

In order to run this application I included my GMAIL credentials in the Rails secrets store, with
the following format

```
google:
  email: a_valid_email
  password: a_generated_app_key
```

Creating an app key for your account should make it so you would be able to run the code and use
your own mail if you want to.

## Unfinished tasks

- The code as it sits is only able to send emails through the SMTP protocol, is not able to do IMAP.
- Markdown editor is in early WIP state. I have a branch up called `markdown_editor` with an
unfinished VueJS form for an email. It has the expected inputs, but it does not POST to the Rails app.

## Todo

- Improve Email parsing, current behavior leads to errors:
 - Mails that have been replied to have different structure
 - Current Regex approach is very fragile