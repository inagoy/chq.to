class AccessController < ApplicationController
  def access
    @slug = params[:slug]
    link = Link.find_by(slug: @slug)
    if !link.nil? && link.accessible?
      if link.is_a?(ExclusiveLink)
        render 'access/insert_password'
      else
        link.visits.create(ip: request.remote_ip)
        redirect_to link.url, allow_other_host: true
      end
    elsif !link.nil? && link.is_a?(EphemeralLink)
      render file: "#{Rails.root}/public/403.html", layout: false, status: :not_found
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  def validate_password
    @slug = params[:slug]
    password = params[:password]
    link = Link.find_by(slug: @slug)

    if !link.nil? && link.authenticated?(password)
      link.visits.create(ip: request.remote_ip)
      redirect_to link.url, allow_other_host: true
    else
      redirect_to access_path(slug: @slug), alert: "Wrong password"
    end
  end
end
