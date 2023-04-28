# Ansible Role: Usersetup

An Ansible Role that sets up my user account (and optional additional accounts) on Linux.

[TOC]

## Requirements

* [Python `bcrypt` module](https://pypi.org/project/bcrypt/)

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### Main Variables

    usersetup_packages:
      - zsh

The optional variable `usersetup_packages` defines a list of packages which will be installed before configuring the users.

    usersetup_factsdir: "hostfacts"

The optional variable `usersetup_factsdir` defines the path root on the ansible controller in which to store the facts for the created users,
at the moment this is only the passwords.

---

    usersetup_users: []

The optional variable `usersetup_users` defines the list of users to be created or removed.
The possible keys for each user are as follows:

        state: present

The `state` key is optional and defaults to 'present'. Set it to 'absent' to remove the user account with the given name.

        name

The `name` key is mandatory.

        group

The `group` key is optional and defaults to the value of the `name` key.

        groups: []

The `groups` key is optional and defaults to an empty list.

        password

The `password` key is optional and defines the password to be set for that user account.
If no password is given, a random one is generated.
The password will be stored beneath the path defined via `usersetup_factsdir` on the ansible controller.

        keys: []

The `keys` key is optional and defaults to an empty list. Each item accepts the same values as the `key` parameter of the ansible.posix.authorized_key module.

        exclusivekeys: false

The `exclusivekeys` key is optional and defaults to `false`. It follows the same behavior as the `exclusive` parameter of the ansible.posix.authorized_key module.

        shell: /bin/zsh

The `shell` key is optional and defaults to '/bin/zsh', hence the 'zsh' which is installed beforehand.
It controls which shell will be set for that user.

        ohmyzsh: false

The `ohmyzsh` key is optional and defaults to `false`. It controls whether Oh-My-ZSH will be installed for that user.
This only applies if the `shell` key is set to '/bin/zsh'.

        comment

The `ohmyzsh` key is optional and will be omitted by default. It controls the GECOS field of the user account.
(Follows the same rules as the `comment` parameter of the ansible.builtin.user module)

---

    usersetup_max:
      name: max
      groups:
        - sudo
      keys:
        - https://gitlab.com/MaxValue.keys
      appendkeys: false
      ohmyzsh: true
      comment: User for Max Fuxjäger

The optional variable `usersetup_max` defines the settings for my user. If you don't want to create this user, set this variable to an empty dictionary.

    usersetup_nolog: true

The optional variable `usersetup_nolog` sets whether to log sensitive information or not.

### Internal variables

These are variables internally created by the role. Please do not use them in your code.

    _hostfactsdir: "{{ usersetup_factsdir+'/'+inventory_hostname }}"

The internal variable `_hostfactsdir` sets the actual path where the facts files will be stored.

    _usersetup_users

The internal variable `_usersetup_users` defines the complete list of defined users.
These include the users which will be created/configured as well as the users which will be removed.

    _usersetup_users_add

The internal variable `_usersetup_users_add` contains the list of users which will be added/configured.

    _usersetup_users_add_pw

The internal variable `_usersetup_users_add_pw` contains the list of users which will be added/configured but every user entry is ensured to have a password configured.

    _result_users_create

The internal variable `_result_users_create` contains the result of the user creation task and is used to find the home directory of each user later on.

    _usersetup_users_remove

The internal variable `_usersetup_users_remove` contains the list of users which will be removed.

## Dependencies

* The community.general collection: `ansible-galaxy collection install --force community.general`

## Example Playbooks

### Normal usage

    ---
    # This creates the default set of users
    - hosts: localhost
      roles:
        - maxvalue.usersetup
    ...

### Add only own users

    ---
    # This creates only your own custom defined users
    - hosts: localhost
      roles:
        - role:
            name: maxvalue.usersetup
          vars:
            usersetup_max:
            usersetup_users:
              - name: bob
                groups:
                  - sudo
    ...

## License

[MIT](LICENSE.txt)

## Sponsors

You can support the development of this role and other similar roles by donating to one of the accounts below.

* [bymeacoffee](https://www.buymeacoffee.com/publicbetamax)
* [liberapay](https://de.liberapay.com/maxvalue/)
* [ko-fi](https://ko-fi.com/publicbetamax)
* [Patreon](patreon.com/publicbetamax)

## Author Information

This role was created in 2022 by Max Fuxjäger:
* Mastodon: [@maxvalue@chaos.social](https://chaos.social/@maxvalue)
* Matrix: @ypsilon:matrix.org
