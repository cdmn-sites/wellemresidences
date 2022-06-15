class AddAccountIds < ActiveRecord::Migration[7.0]
  def change
    tables = [
      :spina_users,
      :spina_pages,
      :spina_image_collections,
      :spina_attachment_collections,
      :spina_images,
      :spina_media_folders,
      :spina_navigations,
      :spina_navigation_items,
      :spina_page_parts,
      :spina_settings,
      :spina_rewrite_rules
    ]

    for table in tables
      add_column table, :account_id, :integer
      add_index table, :account_id
    end
    
    add_column :spina_accounts, :domain, :string
    add_column :spina_accounts, :subdomain, :string
    add_index :spina_accounts, :domain
    add_index :spina_accounts, :subdomain

    Spina::User.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::Page.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::Image.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::MediaFolder.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::Navigation.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::NavigationItem.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::Setting.update_all ['account_id = ?', Spina::Account.first.id]
    Spina::RewriteRule.update_all ['account_id = ?', Spina::Account.first.id]
    RoomType.update_all ['account_id = ?', Spina::Account.first.id]
  end
end
