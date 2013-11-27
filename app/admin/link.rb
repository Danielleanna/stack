ActiveAdmin.register Link do

  index do
    id_column
    column :name
    column :url
    column :created_at
    default_actions
  end


end
