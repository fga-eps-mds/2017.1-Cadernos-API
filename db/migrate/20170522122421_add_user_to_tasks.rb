class AddUserToTasks < ActiveRecord::Migration[5.0]
  def change
    User.transaction do
      begin
        @user = User.first

        Task.transaction do
          Task.connection.execute "UPDATE tasks SET user_id = #{@user.id}"
        end
      rescue
        say "No user found to set tasks"
      end
    end
  end
end
