class ApplicationsController < ApplicationController

    def index
        apps = Application.all
        render :json => {
            success: true,
            data: {
              apps: apps
            }
          }
    end
    
    def create
        app = Application.new(create_params)
        app.token = SecureRandom.uuid
        if app.save!
            render :json => {
                success: true,
                data: {
                    token: app.token,
                    name: app.name,
                    chats_count: app.chats_count
                }
            }
        else
            render :json => {
                success: true,
                error: app.errors
            }
        end
    end

    def update
        app = Application.find_by(token: params[:token])
        app.update(update_params)
        if app.save!
            render :json => {
                success: true,
                data: {
                    token: app.token,
                    name: app.name,
                    chats_count: app.chats_count
                }
            }
        else
            render :json => {
                success: true,
                error: app.errors
            }
        end
    end
    

    private

    def create_params
        params.permit(:name)
    end
    
    def update_params
        params.permit(:name)
    end
    
end
