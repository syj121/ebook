class Permission < ApplicationRecord

  has_closure_tree

  has_many :actions, dependent: :destroy
  has_many :role_actions
end