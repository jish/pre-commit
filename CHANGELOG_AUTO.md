# Change Log

## [Unreleased](https://github.com/jish/pre-commit/tree/HEAD)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.23.0...HEAD)

**Merged pull requests:**

- Skip checking when staged files are empty [\#211](https://github.com/jish/pre-commit/pull/211) ([TakiTake](https://github.com/TakiTake))

- Modified ci check to use binstubs or bundle exec if bunstub doesn't exist [\#210](https://github.com/jish/pre-commit/pull/210) ([knovoselic](https://github.com/knovoselic))

## [v0.23.0](https://github.com/jish/pre-commit/tree/v0.23.0) (2015-04-01)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.22.0...v0.23.0)

**Closed issues:**

- No check for byebug [\#206](https://github.com/jish/pre-commit/issues/206)

- puppet plugin [\#202](https://github.com/jish/pre-commit/issues/202)

**Merged pull requests:**

- RuboCop should check more than just .rb files. This commit fixes that problem. [\#208](https://github.com/jish/pre-commit/pull/208) ([knovoselic](https://github.com/knovoselic))

- Readme: Add RVM installation info [\#203](https://github.com/jish/pre-commit/pull/203) ([eikes](https://github.com/eikes))

- With RVM use \_current\_ ruby and gemset, not \_default\_ [\#201](https://github.com/jish/pre-commit/pull/201) ([eikes](https://github.com/eikes))

- Closure\_linter check [\#200](https://github.com/jish/pre-commit/pull/200) ([tsevan](https://github.com/tsevan))

- Prevent result of Cli\#execute\_run from being clobbered. [\#195](https://github.com/jish/pre-commit/pull/195) ([david](https://github.com/david))

- Revert "Allow JRuby failures." [\#179](https://github.com/jish/pre-commit/pull/179) ([mpapis](https://github.com/mpapis))

## [v0.22.0](https://github.com/jish/pre-commit/tree/v0.22.0) (2014-12-10)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.21.0...v0.22.0)

**Closed issues:**

- Better RVM integration. [\#190](https://github.com/jish/pre-commit/issues/190)

**Merged pull requests:**

- Read all versions from schema files in the migration check. [\#191](https://github.com/jish/pre-commit/pull/191) ([jish](https://github.com/jish))

## [v0.21.0](https://github.com/jish/pre-commit/tree/v0.21.0) (2014-10-31)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.20.0...v0.21.0)

**Closed issues:**

- Ignore if there is no rvm in path [\#189](https://github.com/jish/pre-commit/issues/189)

**Merged pull requests:**

- removed php, update \#176 [\#180](https://github.com/jish/pre-commit/pull/180) ([mpapis](https://github.com/mpapis))

## [v0.20.0](https://github.com/jish/pre-commit/tree/v0.20.0) (2014-10-07)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.19.0...v0.20.0)

**Closed issues:**

- Workflow with submodules [\#186](https://github.com/jish/pre-commit/issues/186)

- error on broken symlinks [\#173](https://github.com/jish/pre-commit/issues/173)

- Update the version of JSHint bundled with pre-commit [\#157](https://github.com/jish/pre-commit/issues/157)

- Need a glossary or some documentation [\#156](https://github.com/jish/pre-commit/issues/156)

- Organization for extra plugins [\#152](https://github.com/jish/pre-commit/issues/152)

**Merged pull requests:**

- The local check prefers underscored file names. [\#184](https://github.com/jish/pre-commit/pull/184) ([jish](https://github.com/jish))

- User supplied rubocop flags [\#183](https://github.com/jish/pre-commit/pull/183) ([padde](https://github.com/padde))

- improved shell handling [\#181](https://github.com/jish/pre-commit/pull/181) ([mpapis](https://github.com/mpapis))

- Allow JRuby failures. [\#178](https://github.com/jish/pre-commit/pull/178) ([jish](https://github.com/jish))

- Upgrade JSHint to 2.5.4 [\#177](https://github.com/jish/pre-commit/pull/177) ([jish](https://github.com/jish))

- Do not run checks on broken symlinks. [\#174](https://github.com/jish/pre-commit/pull/174) ([jish](https://github.com/jish))

- pre-commit run all not work [\#172](https://github.com/jish/pre-commit/pull/172) ([afunction](https://github.com/afunction))

## [v0.19.0](https://github.com/jish/pre-commit/tree/v0.19.0) (2014-09-02)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.16.0...v0.19.0)

**Closed issues:**

- Support detection of :focus within specs when using newer hash syntax [\#167](https://github.com/jish/pre-commit/issues/167)

- Migration check reports a failure on initial commit of schema.rb [\#162](https://github.com/jish/pre-commit/issues/162)

- trouble installing [\#154](https://github.com/jish/pre-commit/issues/154)

- failing tests on yaml [\#150](https://github.com/jish/pre-commit/issues/150)

- pre-commit errors out on submodule add [\#149](https://github.com/jish/pre-commit/issues/149)

- Error on commit [\#147](https://github.com/jish/pre-commit/issues/147)

- Rails schema.rb hook [\#143](https://github.com/jish/pre-commit/issues/143)

- Add Chamber Hook [\#141](https://github.com/jish/pre-commit/issues/141)

- Gemfile Path False Positive [\#139](https://github.com/jish/pre-commit/issues/139)

- Debugger False Positive [\#138](https://github.com/jish/pre-commit/issues/138)

- Pluginator dies when searching for "plugins/pre\_commit/checks/js.rb" [\#129](https://github.com/jish/pre-commit/issues/129)

- Do we need default checks? [\#114](https://github.com/jish/pre-commit/issues/114)

**Merged pull requests:**

- Js and Grep test work with Guard. [\#171](https://github.com/jish/pre-commit/pull/171) ([jish](https://github.com/jish))

- Escape filenames before passing them to grep [\#170](https://github.com/jish/pre-commit/pull/170) ([mattbrictson](https://github.com/mattbrictson))

- Update rspec\_focus plugin to support new JSON-style hash syntax [\#169](https://github.com/jish/pre-commit/pull/169) ([pacso](https://github.com/pacso))

- Add "git" option to run cli command to operate on all git-tracked files ... [\#168](https://github.com/jish/pre-commit/pull/168) ([sbull](https://github.com/sbull))

- Allow logging individual check run times. [\#166](https://github.com/jish/pre-commit/pull/166) ([jish](https://github.com/jish))

- Switch to high-quality SVG badges [\#165](https://github.com/jish/pre-commit/pull/165) ([mattbrictson](https://github.com/mattbrictson))

- Strictly check version numbers in migrations. [\#163](https://github.com/jish/pre-commit/pull/163) ([mattbrictson](https://github.com/mattbrictson))

- Fix manually passing files to runner [\#159](https://github.com/jish/pre-commit/pull/159) ([stsc3000](https://github.com/stsc3000))

- Fix pre commit yml references [\#158](https://github.com/jish/pre-commit/pull/158) ([stsc3000](https://github.com/stsc3000))

- Update rubocop.rb [\#151](https://github.com/jish/pre-commit/pull/151) ([zhenyuchen](https://github.com/zhenyuchen))

- Adds --force-exclusion option to rubocop CLI [\#148](https://github.com/jish/pre-commit/pull/148) ([cvortmann](https://github.com/cvortmann))

## [v0.16.0](https://github.com/jish/pre-commit/tree/v0.16.0) (2014-04-10)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.15.0...v0.16.0)

**Closed issues:**

- Add Brakeman Hook [\#140](https://github.com/jish/pre-commit/issues/140)

**Merged pull requests:**

- Check .coffee files for console.log too [\#142](https://github.com/jish/pre-commit/pull/142) ([chuckd](https://github.com/chuckd))

- Added gem post install message. [\#137](https://github.com/jish/pre-commit/pull/137) ([georgeyacoub](https://github.com/georgeyacoub))

- Fix typo \(disbale -\> disable\) [\#136](https://github.com/jish/pre-commit/pull/136) ([edgurgel](https://github.com/edgurgel))

- Add checkstyle check. [\#135](https://github.com/jish/pre-commit/pull/135) ([blatyo](https://github.com/blatyo))

- Add scss-lint check [\#134](https://github.com/jish/pre-commit/pull/134) ([blatyo](https://github.com/blatyo))

- Add yaml check. [\#133](https://github.com/jish/pre-commit/pull/133) ([blatyo](https://github.com/blatyo))

- Add tests for coffeelint [\#132](https://github.com/jish/pre-commit/pull/132) ([blatyo](https://github.com/blatyo))

- Add JSON check [\#131](https://github.com/jish/pre-commit/pull/131) ([blatyo](https://github.com/blatyo))

- Add checkstyle, scss-lint, json, and yaml checks. [\#130](https://github.com/jish/pre-commit/pull/130) ([blatyo](https://github.com/blatyo))

## [v0.15.0](https://github.com/jish/pre-commit/tree/v0.15.0) (2014-03-11)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.14.0...v0.15.0)

**Closed issues:**

- Consistent configuration options [\#125](https://github.com/jish/pre-commit/issues/125)

- Specifying rubocop.yml in git config causes exception [\#124](https://github.com/jish/pre-commit/issues/124)

**Merged pull requests:**

- Provide standard way to specify config file. [\#128](https://github.com/jish/pre-commit/pull/128) ([blatyo](https://github.com/blatyo))

- Add instructions on how to verify gem signature. [\#127](https://github.com/jish/pre-commit/pull/127) ([jish](https://github.com/jish))

- Add the ability to sign gem with X.509 [\#126](https://github.com/jish/pre-commit/pull/126) ([jish](https://github.com/jish))

## [v0.14.0](https://github.com/jish/pre-commit/tree/v0.14.0) (2014-02-18)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.13.0...v0.14.0)

**Closed issues:**

- Broken rubygems package for 0.13? [\#123](https://github.com/jish/pre-commit/issues/123)

**Merged pull requests:**

- adds support for Go source files checks [\#122](https://github.com/jish/pre-commit/pull/122) ([marcosvm](https://github.com/marcosvm))

- Run tests against Ruby 2.1. [\#121](https://github.com/jish/pre-commit/pull/121) ([jish](https://github.com/jish))

- adds support for Go source files checks [\#120](https://github.com/jish/pre-commit/pull/120) ([marcosvm](https://github.com/marcosvm))

## [v0.13.0](https://github.com/jish/pre-commit/tree/v0.13.0) (2014-02-12)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.12.0...v0.13.0)

**Closed issues:**

- enable extra badges [\#108](https://github.com/jish/pre-commit/issues/108)

- pre-commit doesn't appear to work [\#73](https://github.com/jish/pre-commit/issues/73)

**Merged pull requests:**

- Ruby hashrockets should run on rb files [\#117](https://github.com/jish/pre-commit/pull/117) ([georgeyacoub](https://github.com/georgeyacoub))

- Solved uninitialized constant when running Rubocop. [\#113](https://github.com/jish/pre-commit/pull/113) ([georgeyacoub](https://github.com/georgeyacoub))

- timeout for old issues [\#112](https://github.com/jish/pre-commit/pull/112) ([mpapis](https://github.com/mpapis))

- Git configuration should be backwards compatible [\#111](https://github.com/jish/pre-commit/pull/111) ([jish](https://github.com/jish))

- Features/configuration [\#107](https://github.com/jish/pre-commit/pull/107) ([mpapis](https://github.com/mpapis))

- Load configs from .yml files [\#102](https://github.com/jish/pre-commit/pull/102) ([georgeyacoub](https://github.com/georgeyacoub))

- Stash uns-taged changes temporarily [\#101](https://github.com/jish/pre-commit/pull/101) ([georgeyacoub](https://github.com/georgeyacoub))

- Add CSS lint support [\#18](https://github.com/jish/pre-commit/pull/18) ([jish](https://github.com/jish))

## [v0.12.0](https://github.com/jish/pre-commit/tree/v0.12.0) (2013-12-30)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.10.0...v0.12.0)

**Closed issues:**

- rvm default do ruby [\#97](https://github.com/jish/pre-commit/issues/97)

- please use the original JSHint default [\#94](https://github.com/jish/pre-commit/issues/94)

- Make pre-commit extensible via API/configuration [\#92](https://github.com/jish/pre-commit/issues/92)

- License missing from gemspec [\#87](https://github.com/jish/pre-commit/issues/87)

- Build failure due to celluloid not supporting older Ruby versions. [\#85](https://github.com/jish/pre-commit/issues/85)

**Merged pull requests:**

- force utf-8 encoding [\#109](https://github.com/jish/pre-commit/pull/109) ([pjurczynski](https://github.com/pjurczynski))

- Features/warnings [\#106](https://github.com/jish/pre-commit/pull/106) ([mpapis](https://github.com/mpapis))

- Manual hook [\#105](https://github.com/jish/pre-commit/pull/105) ([jish](https://github.com/jish))

- add support plugins [\#104](https://github.com/jish/pre-commit/pull/104) ([mpapis](https://github.com/mpapis))

- add license, closes \#87 [\#103](https://github.com/jish/pre-commit/pull/103) ([mpapis](https://github.com/mpapis))

- Add support for coffeelint [\#100](https://github.com/jish/pre-commit/pull/100) ([georgeyacoub](https://github.com/georgeyacoub))

- Use bundle exec for ruby version [\#99](https://github.com/jish/pre-commit/pull/99) ([georgeyacoub](https://github.com/georgeyacoub))

- rewrite the hook in pure sh shell [\#98](https://github.com/jish/pre-commit/pull/98) ([mpapis](https://github.com/mpapis))

- Fix whitespace checker for case sensitive OSs \(aka linux\) [\#96](https://github.com/jish/pre-commit/pull/96) ([filipegiusti](https://github.com/filipegiusti))

- Add a before\_all check [\#95](https://github.com/jish/pre-commit/pull/95) ([markprzepiora](https://github.com/markprzepiora))

- Attempt to run checks in process first. [\#91](https://github.com/jish/pre-commit/pull/91) ([jish](https://github.com/jish))

- Just use Ruby [\#90](https://github.com/jish/pre-commit/pull/90) ([bquorning](https://github.com/bquorning))

- support warnings in addition to errors on commit [\#88](https://github.com/jish/pre-commit/pull/88) ([bglusman](https://github.com/bglusman))

- hardwired dependencies for execjs [\#21](https://github.com/jish/pre-commit/pull/21) ([HakubJozak](https://github.com/HakubJozak))

## [v0.10.0](https://github.com/jish/pre-commit/tree/v0.10.0) (2013-10-25)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.1.18...v0.10.0)

**Closed issues:**

- Halts on debugger in Gemfile.lock [\#82](https://github.com/jish/pre-commit/issues/82)

- How to apply codesniffer pre-commit for only project folder? [\#80](https://github.com/jish/pre-commit/issues/80)

- Update JSHint [\#79](https://github.com/jish/pre-commit/issues/79)

- alert on nb-spaces [\#68](https://github.com/jish/pre-commit/issues/68)

- pre-commit not found \(non-RVM\) [\#65](https://github.com/jish/pre-commit/issues/65)

- ruby cannot find pre-commit [\#63](https://github.com/jish/pre-commit/issues/63)

- Travis builds suddenly started failing [\#59](https://github.com/jish/pre-commit/issues/59)

- Add RSpec check [\#55](https://github.com/jish/pre-commit/issues/55)

- How to configure JSHint options [\#45](https://github.com/jish/pre-commit/issues/45)

- uninitialized constant PreCommit::RubySymbolHashrockets [\#43](https://github.com/jish/pre-commit/issues/43)

- PDF/PSDs seem to cause some issues [\#40](https://github.com/jish/pre-commit/issues/40)

- grep warning in Mountiain Lion [\#33](https://github.com/jish/pre-commit/issues/33)

- Add merge conflict check to the list of default checks [\#32](https://github.com/jish/pre-commit/issues/32)

- Segfault [\#29](https://github.com/jish/pre-commit/issues/29)

- Console log check should not run on non-js files [\#28](https://github.com/jish/pre-commit/issues/28)

- issue invoking with /usr/bin/env [\#26](https://github.com/jish/pre-commit/issues/26)

- LoadError when upgrading your ruby version [\#24](https://github.com/jish/pre-commit/issues/24)

- Add local path checking for Gemfiles [\#23](https://github.com/jish/pre-commit/issues/23)

- The console.log check should only look it staged chunks [\#14](https://github.com/jish/pre-commit/issues/14)

**Merged pull requests:**

- Migration version check [\#84](https://github.com/jish/pre-commit/pull/84) ([grosser](https://github.com/grosser))

- avoid large or binary files [\#78](https://github.com/jish/pre-commit/pull/78) ([grosser](https://github.com/grosser))

- add gemfile path check fixes \#23 [\#77](https://github.com/jish/pre-commit/pull/77) ([grosser](https://github.com/grosser))

- overwrite when installing [\#76](https://github.com/jish/pre-commit/pull/76) ([grosser](https://github.com/grosser))

- Cleanup utils [\#75](https://github.com/jish/pre-commit/pull/75) ([bquorning](https://github.com/bquorning))

- Faster check for trailing whitespace [\#74](https://github.com/jish/pre-commit/pull/74) ([bquorning](https://github.com/bquorning))

- simplify lint [\#72](https://github.com/jish/pre-commit/pull/72) ([grosser](https://github.com/grosser))

- convert to simpler interface [\#71](https://github.com/jish/pre-commit/pull/71) ([grosser](https://github.com/grosser))

- simplify ci task, do not add it if you do not have rake or a ci task [\#70](https://github.com/jish/pre-commit/pull/70) ([grosser](https://github.com/grosser))

- introducing nb space check [\#69](https://github.com/jish/pre-commit/pull/69) ([grosser](https://github.com/grosser))

- adding spec directory to checked dirs of pry and debugger [\#67](https://github.com/jish/pre-commit/pull/67) ([hasghari](https://github.com/hasghari))

- Josh/system ruby support [\#66](https://github.com/jish/pre-commit/pull/66) ([jish](https://github.com/jish))

- Use plain ruby, dont use system calls. [\#64](https://github.com/jish/pre-commit/pull/64) ([jwaldrip](https://github.com/jwaldrip))

- Misc. fixes: silence `which`, add force install [\#62](https://github.com/jish/pre-commit/pull/62) ([mnzaki](https://github.com/mnzaki))

- Add Rubocop check [\#61](https://github.com/jish/pre-commit/pull/61) ([mnzaki](https://github.com/mnzaki))

- Rspec focus check2 [\#60](https://github.com/jish/pre-commit/pull/60) ([jamesbarnett](https://github.com/jamesbarnett))

- Fix hashrocket pattern [\#58](https://github.com/jish/pre-commit/pull/58) ([zzet](https://github.com/zzet))

- Fix loading pre-commit [\#57](https://github.com/jish/pre-commit/pull/57) ([mikz](https://github.com/mikz))

- Creates a check to prevent :focus in rspec files from being committed [\#56](https://github.com/jish/pre-commit/pull/56) ([jamesbarnett](https://github.com/jamesbarnett))

- Update README.md [\#53](https://github.com/jish/pre-commit/pull/53) ([mikedfunk](https://github.com/mikedfunk))

- Add Pry Check [\#52](https://github.com/jish/pre-commit/pull/52) ([samadhiBot](https://github.com/samadhiBot))

- Update templates/pre-commit-hook [\#51](https://github.com/jish/pre-commit/pull/51) ([zzet](https://github.com/zzet))

- add local check for customized pre-commit checking [\#50](https://github.com/jish/pre-commit/pull/50) ([grosser](https://github.com/grosser))

- Moving all classes under the PreCommit namespace. [\#49](https://github.com/jish/pre-commit/pull/49) ([jish](https://github.com/jish))

- test cleanup and integration testing [\#48](https://github.com/jish/pre-commit/pull/48) ([grosser](https://github.com/grosser))

- dry [\#47](https://github.com/jish/pre-commit/pull/47) ([grosser](https://github.com/grosser))

- namespaces are fun! [\#46](https://github.com/jish/pre-commit/pull/46) ([grosser](https://github.com/grosser))

- Properly require ruby\_symbol\_hashrockets. [\#44](https://github.com/jish/pre-commit/pull/44) ([darrenboyd](https://github.com/darrenboyd))

- No hasrockets [\#42](https://github.com/jish/pre-commit/pull/42) ([libo](https://github.com/libo))

- Adds support for rbenv [\#41](https://github.com/jish/pre-commit/pull/41) ([hsume2](https://github.com/hsume2))

- Warning and passing when pre-commit fails to load. [\#39](https://github.com/jish/pre-commit/pull/39) ([jish](https://github.com/jish))

- console.log check should ignore non-JS files [\#38](https://github.com/jish/pre-commit/pull/38) ([shajith](https://github.com/shajith))

- Checking for the presence of the pre-commit gem. [\#37](https://github.com/jish/pre-commit/pull/37) ([jish](https://github.com/jish))

- Detect if pre-commit is actually installed in the ruby we are using. [\#36](https://github.com/jish/pre-commit/pull/36) ([libo](https://github.com/libo))

- handling -P going missing in Mountain Lion's grep. [\#35](https://github.com/jish/pre-commit/pull/35) ([shajith](https://github.com/shajith))

- Mountain Lion's grep doesn't have a -P [\#34](https://github.com/jish/pre-commit/pull/34) ([shajith](https://github.com/shajith))

- Giving the option to overwrite hook during installation. [\#31](https://github.com/jish/pre-commit/pull/31) ([jish](https://github.com/jish))

- wip: env-detecting and shelling out in the installed pre-commit script [\#30](https://github.com/jish/pre-commit/pull/30) ([shajith](https://github.com/shajith))

- Fixing usage of jshint with execjs, so that we don't depend on a patched jshint.js... [\#27](https://github.com/jish/pre-commit/pull/27) ([carhartl](https://github.com/carhartl))

## [v0.1.18](https://github.com/jish/pre-commit/tree/v0.1.18) (2012-02-15)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.1.11...v0.1.18)

**Closed issues:**

- Merge conflict doesn't check the reverse side [\#19](https://github.com/jish/pre-commit/issues/19)

- JSHint check blows up when there are many errors in a file [\#16](https://github.com/jish/pre-commit/issues/16)

- Known problems when using RVM gemsets? [\#11](https://github.com/jish/pre-commit/issues/11)

- Switch from therubyracer to ExecJS [\#10](https://github.com/jish/pre-commit/issues/10)

- console.log statements that are commented out should pass checks [\#9](https://github.com/jish/pre-commit/issues/9)

**Merged pull requests:**

- Getting out errors from JSHINT [\#25](https://github.com/jish/pre-commit/pull/25) ([carhartl](https://github.com/carhartl))

- Php lint [\#22](https://github.com/jish/pre-commit/pull/22) ([deviantintegral](https://github.com/deviantintegral))

- Fixed a simple typo in an error message. [\#20](https://github.com/jish/pre-commit/pull/20) ([darrenboyd](https://github.com/darrenboyd))

- Ci [\#17](https://github.com/jish/pre-commit/pull/17) ([jish](https://github.com/jish))

- Ported JS\[LH\]int checks to use ExecJS, also did some refactoring. [\#12](https://github.com/jish/pre-commit/pull/12) ([shajith](https://github.com/shajith))

## [v0.1.11](https://github.com/jish/pre-commit/tree/v0.1.11) (2011-05-11)

[Full Changelog](https://github.com/jish/pre-commit/compare/v0.1.10...v0.1.11)

**Closed issues:**

- Migration sanity check part 2. [\#8](https://github.com/jish/pre-commit/issues/8)

- Add a migration sanity check [\#7](https://github.com/jish/pre-commit/issues/7)

## [v0.1.10](https://github.com/jish/pre-commit/tree/v0.1.10) (2011-05-05)

**Closed issues:**

- Add JSHint support [\#6](https://github.com/jish/pre-commit/issues/6)

- JSLint check is breaking on all "new" js files [\#5](https://github.com/jish/pre-commit/issues/5)

- pre-commit executable should respond to version [\#4](https://github.com/jish/pre-commit/issues/4)

- Whitespace check should have an explanation [\#3](https://github.com/jish/pre-commit/issues/3)



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*