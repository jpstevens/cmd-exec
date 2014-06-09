module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffeelint: {
      files: ["src/*.coffee", "src/**/*.coffee", "tests/*.coffee", "tests/**/*.coffee"],
      options: {
        max_line_length: {
          level: "ignore"
        }
      }
    },
    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: true,
        cwd: 'src/',
        src: ['*.coffee'],
        dest: 'dist/',
        ext: '.js'
      }
    },
    clean: ["dist/"],
    mochaTest: {
      feature: {
        options: {
          reporter: 'spec',
          require: 'coffee-script/register',
          colors: true
        },
        src: ['tests/feature/*-spec.coffee']
      }
    }
  });

  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-mocha-test');

  grunt.registerTask('test', ['mochaTest']);
  grunt.registerTask('build', ['coffeelint', 'clean', 'coffee']);
  grunt.registerTask('default', ['build']);
};