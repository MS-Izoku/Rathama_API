# Tech Debt
Every app, every company, everyone has tech debt.  Best thing we can do is make note of it when we see it.

## Known Debt
* ActiveStorage configures itself everytime an image is uploaded.  Although consistent, using a before_action is not the best idea.