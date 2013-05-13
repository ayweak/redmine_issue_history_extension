# -*- coding: utf-8 -*-

class IssueHistoryExtensionHookListener < Redmine::Hook::ViewListener
  def view_issues_show_description_bottom(context={})
    if !context[:issue].journals.present?
      return ''
    end

    label_order = ''
    class_order = ''

    if User.current.pref[:comments_sorting] == 'desc'
      label_order = l(:issue_history_extension_order_desc)
      class_order = 'desc'
    else
      label_order = l(:issue_history_extension_order_asc)
      class_order = 'asc'
    end

    context[:hook_caller].send(
      :render,
      {
        :partial => 'hooks/issue_history_extension/view_issues_show_description_bottom',
        :locals => { :label_order => label_order, :class_order => class_order }
      }
    )
  end
end
