class UserDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :check_box_tag, :link_to, :mail_to, :edit_admin_user_path, :admin_user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: "User.id", cond: :eq },
      confirmed: { source: "User.confirmed?", searchable: false},
      email: { source: "User.email", cond: :like },
      name: { source: "User.name", cond: :like },
      roles: { source: "User.get_roles", searchable: false },
      dt_action_view: { source: "User.id", searchable: false, orderable: false },
      dt_action_edit: { source: "User.id", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        confirmed: check_box_tag(record.id,
            record.id,
            record.confirmed?,
            method: :patch,
            url: "/admin/users/#{record.id}/toggle_confirmation?user[to_confirm]=",
            class: 'switch-checkbox',
            readonly: !@view.can?(:toggle_confirmation, record),
            data: { size: 'small', on_color: 'success', off_color: 'warning', on_text: 'Yes', off_text: 'No' }
            ),
        email: record.email,
        name: record.name,
        roles: self.format_roles(record.get_roles),
        dt_action_view: dt_action_view(record),
        dt_action_edit: dt_action_edit(record)
      }
    end
  end

  def dt_action_view(record)
    link_to('View', admin_user_path(record), class: 'btn btn-success')
  end

  def dt_action_edit(record)
    link_to('Edit', edit_admin_user_path(record), class: 'btn btn-primary')
  end


  def get_raw_records
    User.all.includes(:roles)
  end

  def format_roles(roles)
    return 'None' if roles.blank?
    roles.map{ |x| x[0].titleize + ' (' + x[1].join(', ') + ')' }.join ', '
  end

end
