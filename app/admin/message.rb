ActiveAdmin.register Message do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  actions :index, :destroy
  index do
    column :body
    column :listing do |message|
      link_to(message.chat_room.listing.name, detail_listings_path(message.chat_room.listing.slug)) rescue 'NA'
    end
    column :receiver, sortable: true
    column :sender, sortable: true
    column :created_at
    column :read
  end
end
