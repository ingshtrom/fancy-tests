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
      root: [path.join(buildDir, '**')]
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
          {expand: true, flatten: true, cwd: 'client/src/scripts', src: ['*.coffee'], dest: path.join(clientBuildDir, 'src/scripts'), ext: '.js'}
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
          # copy the JS files (the rest should be .coffee scripts that are compiled)
          {expand: true, src: ['client/src/scripts/*.js'], dest: buildDir},
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


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'

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

  grunt.registerTask 'default', 'clean, build, and test all code', () ->
    grunt.task.run ['clean:root', 'deploy', 'test']

  ###############
  ### Deploy  ###
  ###############

  grunt.registerTask 'deploy', 'clean and build all code', () ->
    grunt.task.run ['clean:root', 'dist-client', 'dist-server']

  grunt.registerTask 'dist-client', 'clean, build, and test client code', () ->
    grunt.task.run ['clean:client']
    create_client_pub_dirs()
    create_log_dirs()
    grunt.task.run ['coffeelint:client', 'coffee:client', 'jade:client', 'copy:client']

  grunt.registerTask 'dist-server', 'clean, build, and test server code', () ->
    grunt.task.run ['clean:server']
    create_server_pub_dirs()
    create_log_dirs()
    grunt.task.run ['coffeelint:server', 'coffee:server', 'copy:server']

  ###############
  ### TESTING ###
  ###############
  grunt.registerTask 'test', 'test all code', () ->
    grunt.task.run ['test-client', 'test-server']

  grunt.registerTask 'test-client', 'test client code', () ->
    grunt.log.write 'nothing to do yet...'

  grunt.registerTask 'test-server', 'test server code', () ->
    grunt.log.write 'nothing to do yet...'