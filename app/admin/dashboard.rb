ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome to Threadhabits Admin Dashboard"
        small "You can manage Site content, users, listings and various things from here."
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns(class: "dashboard columns") do
      column do
        panel "Recent Users Registered" do
          div(class: "dashboard-panel") do
            table_for Person.recent(5) do
              column :full_name
              column :username
              column :location
              column :account_confirmed_at do |p|
                I18n.l p.confirmed_at, format: :short_date rescue nil
              end
            end
          end
          div(class: "view-all") {
            strong { link_to "View All Users", admin_users_path }
          }
        end
      end

      column do
        panel "Recent Listings" do
          div(class: "dashboard-panel") do
            table_for Listing.recent(5) do
              column :name
              column :person
              column :price
              column :location do |l|
                l.address.try(:location)
              end
              column :created_at do |l|
                I18n.l l.created_at, format: :short_date rescue nil
              end
            end
          end
          div(class: "view-all") {
            strong { link_to "View All Listings", admin_listings_path }
          }
        end
      end
    end
  end # content
end
