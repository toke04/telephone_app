module ApplicationHelper

  # bootstrapによる、deviceエラーメッセージ →https://qiita.com/take18k_tech/items/a36d77316e32a6696205
  def bootstrap_devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    resource.errors.full_messages.each do |error_message|
      html += <<-EOF
      <div class="alert alert-danger alert-dismissible" role="alert">
       
        #{error_message}
      </div>
      EOF
    end
    html.html_safe
  end

  #「icon」メソッドで、bootstrapのiconが使える
  def icon(icon, options = {})
    file = File.read("node_modules/bootstrap-icons/icons/#{icon}.svg")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] += " " + options[:class]
    end
      doc.to_html.html_safe
  end

end
