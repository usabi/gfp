class Content < ActiveRecord::Base
  attr_accessible :name, :criterion_id, :contentblock_id, :c_id
  belongs_to :criterion
  belongs_to :contentblock
end
