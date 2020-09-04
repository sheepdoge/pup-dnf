#!/bin/bash

set -e

test::check_syntax() {
  ansible-playbook playbook.yml -i 'localhost' -e '{"packages_to_install": ["i3"], "packages_to_uninstall": ["ripgrep"]}' --syntax-check
}

test::run_ansible() {
  ansible-playbook playbook.yml -i 'localhost' -e '{"packages_to_install": ["i3"], "packages_to_uninstall": ["ripgrep"]}'
}

test::assert_output() {
  for package in i3; do
    if ! dnf list installed | grep -q $package; then
      echo "$package is not installed"
      exit 1
    fi
  done

  for package in ripgrep; do
    if which "$package"; then
      echo "$package is installed, and should not be"
      exit 1
    fi
  done
}

test::check_syntax
test::run_ansible
test::assert_output
