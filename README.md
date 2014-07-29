fancy-tests
===========

Graph the results of various test results.

Web Server Configuration
------------------------
I couldn't get nginx to work with [Cloud9](https://c9.io/), so I built everything assuming a basic Apache web server whose root is pub/client/src/views/.

File Organization
-----------------
- client
  - src
    - fonts
      - ext_lib
      - ...
    - images
      - ext_lib
      - ...
    - scripts
      - ext_lib
      - ...
    - styles
      - ext_lib
      - ...
    - views
      - ext_lib
      - ...
    - index.coffee
  - test
    - ...
- server
  - schemas
    - ...
  - index.coffee
- pub (created from Grunt)
  - client
    - images
      - ...
    - scripts
      - ...
    - styles
      - ...
  - server
    - schemas
      - ...
    - index.coffee