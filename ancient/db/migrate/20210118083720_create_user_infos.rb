class CreateUserInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.integer :user_id
      t.string :nick_name, comment: "昵称"
      t.string :email, comment: "邮箱"
      t.string :mobile, comment: "手机号"
      t.string :avatar_url, comment: "头像"
      t.text :personal_desc, comment: "个性化描述"
      t.timestamps
      t.index :user_id, unique: true
    end

    create_table :user_imgs do |t|
      t.integer :user_id
      t.string :avatar_url, comment: "图片地址"
      t.string :name, comment: "图片名"
      t.string :contet_type, comment: "图片类型"
    end
  end
end
