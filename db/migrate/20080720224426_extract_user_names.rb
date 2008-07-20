class ExtractUserNames < ActiveRecord::Migration
  def self.up
    add_column :messages, 'nickname_id', :integer
    Message.all.each do |message|
      nickname = Nickname.find_or_create_by_name(message.nickname)
      message.update_attribute(:nickname_id, nickname.id)
    end
    remove_column :messages, 'nickname'
  end

  def self.down
  end
end
