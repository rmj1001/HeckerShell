#!/usr/bin/env zsh
#
# Plugin Name: zmanage
# Description: Advanced manager for the ZSH shell
# Author(s): RMCJ <rmichael1001@gmail.com>
#

zmanage() {

	LS() {
		path="$(realpath ${1})"
		dir="${PWD}"

		cd ${path} && find . -maxdepth 1 -type f -exec echo "{}" \; | sed -e 's|\.zsh||g' -e 's|\./||g'
		cd ${dir}
	}

	_plugins() {
		_plugins.create() {
			file="${zPluginsPath}/${1}.zsh"

			[[ -f "${file}" ]] && PRINT "Plugin exists!" && return 1 || touch ${file}

			PRINT "#!/usr/bin/env zsh\n#\n# Plugin Name: \n# Description: \n# Author(s): \n#\n\n" >${file}

			edit ${file}

			PRINT "zsh: Created plugin '${1}'!"
		}

		case "$(LOWERCASE $2)" in

		ls) cd ${zPluginsPath} && find . -maxdepth 1 -type f -exec echo "{}" \; | sed -e 's|\.zsh||g' -e 's|\./||g' ;;
		#ls) LS ${zPluginsPath} ;;
		cd) cd ${zPluginsPath} ;;
		edit) [[ -f ${zPluginsPath}/$3.zsh ]] && edit ${zPluginsPath}/${3}.zsh || PRINT "Plugin '${3}' does not exist." ;;
		create) [[ -n "${3}" ]] && _plugins.create ${3} || PRINT "You must provide a name for the plugin." ;;
		*) PRINT "Manage plugins:\n\n- ls (list)\n- cd (change directory)\n- edit <name>\n- create <name>" ;;

		esac
	}

	_sources() {
		_sources.create() {
			file="${zSourcesPath}/${1}.zsh"

			[[ -f "${file}" ]] && PRINT "Source file exists!" && return 1 || touch ${file}

			PRINT "#!/usr/bin/env zsh\n#\n# Source Name: \n# Description: \n# Author(s): \n#\n\n" >${file}

			edit ${file}

			PRINT "zsh: Created source '${1}'!"
		}

		case "$(LOWERCASE $2)" in

		ls) cd ${zSourcesPath} && find . -maxdepth 1 -type f -exec echo "{}" \; | sed -e 's|\.zsh||g' -e 's|\./||g' ;;
		cd) cd ${zSourcesPath} ;;
		edit) [[ -f ${zSourcesPath}/$3.zsh ]] && edit ${zSourcesPath}/${3}.zsh || PRINT "Source '${3}' does not exist." ;;
		create) [[ -n "${3}" ]] && _sources.create ${3} || PRINT "You must provide a name for the source." ;;
		*) PRINT "Manage sources:\n\n- ls (list)\n- cd (change directory)\n- edit <name>\n- create <name>" ;;

		esac
	}

	_settings() {
		_settings.create() {
			file="${zSettingsPath}/${1}.zsh"

			[[ -f "${file}" ]] && PRINT "Settings file exists!" && return 1 || touch ${file}

			PRINT "#!/usr/bin/env zsh\n#\n# Settings Name: \n# Description: \n# Author(s): \n#\n\n" >${file}

			edit ${file}

			PRINT "zsh: Created settings file '${1}'!"
		}

		case "$(LOWERCASE $2)" in

		ls) cd ${zSettingsPath} && find . -maxdepth 1 -type f -exec echo "{}" \; | sed -e 's|\.zsh||g' -e 's|\./||g' ;;
		cd) cd ${zSettingsPath} ;;
		zshrc) edit ${zshrc} ;;
		edit) [[ -f ${zSettingsPath}/$3.zsh ]] && edit ${zSettingsPath}/${3}.zsh || PRINT "Settings file '${3}' does not exist." ;;
		create) [[ -n "${3}" ]] && _settings.create ${3} || PRINT "You must provide a name for the settings file." ;;
		*) PRINT "Manage settings:\n\n- ls (list)\n- cd (change directory)\n- zshrc (edit zshrc)\n- edit <name>\n- create <name>" ;;

		esac
	}

	_reload() {
		case "$(LOWERCASE $2)" in

		all) zsh.load_all && PRINT "\nReloaded all configs." ;;
		settings) zsh.load_settings && PRINT "\nReloaded settings." ;;
		plugins) zsh.load_plugins && PRINT "\nReloaded plugins." ;;
		sources) zsh.load_sources && PRINT "\nReloaded sources." ;;
		shell)
			clear
			exec ${SHELL}
			;;
		*) PRINT "Reload configs:\n\n- all\n- settings\n- plugins\n- sources\n- shell" ;;

		esac
	}

	local cmd="$1"

	case "$(LOWERCASE ${cmd})" in

	reload) _reload $@ && return 0 ;;
	plugins) _plugins $@ && return 0 ;;
	settings) _settings $@ && return 0 ;;
	sources) _sources $@ && return 0 ;;

	esac

	PRINT "Usage: zmanage [command] [args?]"
	PRINT
	PRINT "Subcommands:"
	PRINT "- reload (reload configs or shell)"
	PRINT "- plugins (manage plugins)"
	PRINT "- settings (manage settings)"
	PRINT "- sources (manage sources)"
}
