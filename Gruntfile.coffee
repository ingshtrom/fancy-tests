path = require 'path'

module.exports = (grunt) ->
  buildDir = 'pub'
  clientBuildDir = path.join(buildDir, 'client')
  serverBuildDir = path.join(buildDir, 'server')

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),
    clean:
      options:
        force: true
      client: [path.join(clientBuildDir, '**')]
      server: [path.join(serverBuildDir, '**')]
    coffeelint:
      options:
        max_line_length:
          level: 'ignore'
        no_trailing_whitespace:
          level: 'ignore'
      client: ['client/**/*.coffee']
      server: ['server/**/*.coffee']
    coffee:
      client:
        options:
          bare: true
        files: [
          'pub/client/src/scripts/main.js':         ['client/src/scripts/main.coffee'],
          'pub/client/src/scripts/classes.js':      ['client/src/scripts/classes/**/*.coffee'],
          'pub/client/src/scripts/controllers.js':  ['client/src/scripts/controllers/**/*.coffee'],
          'pub/client/src/scripts/services.js':     ['client/src/scripts/services/**/*.coffee']
        ]
      server:
        options:
          bare: true
        files: [
          {expand: true, flatten: true, cwd: 'server/src/**', src: ['*.coffee'], dest: serverBuildDir, ext: '.js'}
        ]
    copy:
      client:
        files: [
          # copy the image files
          {expand: true, src: ['client/src/images/**'], dest: buildDir},
          # copy all CSS files
          {expand: true, src: ['client/src/stylesheets/**'], dest: buildDir},
          # copy all HTML templates (ideally should be none)
          {expand: true, src: ['client/src/views/*.html'], dest: buildDir}
        ]
      server:
        files: []
    jade:
      options:
        pretty: true
        # client: true
      client:
        files: [
          {expand: true, src: ['client/src/views/*.jade', '!client/src/views/base.jade'], dest: buildDir, ext: '.html'}
        ]
    bower_concat:
      all:
        dest: path.join clientBuildDir, 'src/scripts/bower.js'
        dependencies:
          'angular': ['jquery'] # we can fake this dependency to make sure it loads jquery BEFORE angular
          'angular-animate': ['angular']
          'angular-route': ['angular']
          'angular-bootstrap': ['angular']
          'angular-ui-select2': ['angular', 'select2', 'jquery']
          'angular-ui-calendar': ['angular', 'jquery', 'fullcalendar']
          'bootstrap': ['jquery']
          'jquery': []
          'lodash': []
          'chartjs': []
          'jquery-ui': ['jquery']
          'fullcalendar': ['jquery', 'moment']
          'select2': ['jquery']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-bower-concat'

  create_client_pub_dirs = () ->
    grunt.file.mkdir clientBuildDir
    grunt.file.mkdir path.join(clientBuildDir, 'imag')
    grunt.file.mkdir path.join(clientBuildDir, 'js')
    grunt.file.mkdir path.join(clientBuildDir, 'css')

  create_server_pub_dirs = () ->
    grunt.file.mkdir serverBuildDir

  create_log_dirs = () ->
    logDir = 'logs'
    grunt.file.mkdir(logDir) if !grunt.file.exists(logDir)

  # publish_bower_components = () ->
  #   bowerdir = 'bower_components/'
  #   pubdir = path.join bowerdir, '../pub/client/src/scripts/bower/'
  #   grunt.file.recurse bowerdir,
  #     (abspath, rootdir, subdir, filename) ->
  #       finalDir = path.join pubdir, filename
  #       grunt.file.copy abspath, finalDir

  # grunt.registerTask 'bower:install', 'install bower globally' , () ->
  #   cmdOptions =
  #     cmd: 'node'
  #     grunt: false
  #     args: ['install', '-g', 'bower']
  #   grunt.util.spawn cmdOptions,
  #     (error, result, code) ->
  #       grunt.log.writeln 'result code => ' + result.code
  #       grunt.log.writeln 'stdout => ' + result.stdout
  #       if code != 0
  #         grunt.log.errorlns 'stderr => ' + result.stderr
  #       else
  #         grunt.log.ok('bower installed successfully!')

  grunt.registerTask 'bower:update:components',
    'update all components to the latest version',
    () ->
      grunt.log.ok 'not actually doing anything for now...'
    #   cmdOpts =
    #     cmd: 'bower'
    #     args: ['install']
    #   grunt.util.spawn cmdOpts,
    #     (error, result, code) ->
    #       grunt.log.writeln 'result code => ' + result.code
    #       grunt.log.writeln 'stdout => ' + result.stdout
    #       if code != 0
    #         grunt.log.errorlns 'stderr => ' + result.stderr
    #       else
    #         grunt.log.ok('bower components updated!')

  grunt.registerTask 'default', 'clean, build, and test all code', () ->
    grunt.task.run ['clean:client', 'clean:server', 'bower:update:components', 'deploy', 'test']

  ###############
  ### Deploy  ###
  ###############

  grunt.registerTask 'dist', 'clean and build all code', () ->
    grunt.task.run ['clean:client', 'bower:update:components', 'dist-client', 'dist-server']

  grunt.registerTask 'dist:client', 'clean, build, and test client code', () ->
    grunt.task.run ['clean:client', 'bower:update:components']
    create_client_pub_dirs()
    create_log_dirs()
    # publish_bower_components()
    grunt.task.run ['coffeelint:client', 'coffee:client', 'jade:client', 'copy:client', 'bower_concat:all']

  grunt.registerTask 'dist:server', 'clean, build, and test server code', () ->
    grunt.task.run ['clean:server']
    create_server_pub_dirs()
    create_log_dirs()
    grunt.task.run ['coffeelint:server', 'coffee:server', 'copy:server']

  ###############
  ### TESTING ###
  ###############
  grunt.registerTask 'test', 'test all code', () ->
    grunt.task.run ['test-client', 'test-server']

  grunt.registerTask 'test:client', 'test client code', () ->
    grunt.log.write 'nothing to do yet...'

  grunt.registerTask 'test:server', 'test server code', () ->
    grunt.log.write 'nothing to do yet...'