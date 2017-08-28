# vi: set fileencoding=utf-8
import argparse
import sys
import os
import yaml


def create_symlinks(theme_name):
    with open('{0}/symlinks.yaml'.format(theme_name), 'r') as symlink_file:
        symlinks = yaml.load(symlink_file)

    for symlink_category in symlinks:
        print ('\nInstalling :: {0} symlinks'.format(symlink_category))
        for symlink in symlinks[symlink_category]:
            install_symlink(theme_name, symlinks[symlink_category][symlink])

def install_symlink(theme, symlink):
    src = os.path.abspath('{0}/{1}'.format(theme, symlink['src']))
    dst = os.path.expanduser(symlink['dst'])
    try:
        os.symlink(src, dst)
    except FileExistsError as e:
        os.remove(dst)
        os.symlink(src, dst)
    print('    Symlinked :: {0} -> {1}'.format(symlink['src'], symlink['dst']))

def get_valid_themes():
    with open('themes.yaml', 'r') as themes:
        return yaml.load(themes)

def print_theme_descriptions(valid_themes):
    for theme in valid_themes:
        print('Theme    :: {0}'.format(theme))
        print('Desc     :: {0}'.format(valid_themes[theme]['desc']))
        print('Dotfiles :: {0}'.format(valid_themes[theme]['dotfiles']))
        print('Readme   :: {0}\n'.format(valid_themes[theme]['readme']))

def parse_args():
    parser = argparse.ArgumentParser(description='Autophagy Theme Installer')
    parser.add_argument('-n', '--name', type=str,
                        help='Name of the theme to install')
    parser.add_argument('-l', '--list', action='store_true',
                        help='List valid themes')
    return parser.parse_args()


def main():
    """
    Installs an Autophagian Arch theme via symlinking, based on a theme's
    yaml configuration.
    """
    args = parse_args()
    valid_themes = get_valid_themes()
    if (args.list):
        print_theme_descriptions(valid_themes)
        sys.exit()
    if (args.name is None or args.name not in valid_themes):
        print('You must provide a valid theme name. Valid themes are:')
        print_theme_descriptions(valid_themes)
        sys.exit()
    create_symlinks(args.name)

if __name__ == '__main__':
    sys.exit(main())
