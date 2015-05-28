class EpicenterController < ApplicationController
  def feed
    # Here we initialize the array that will
    # hold tweets from the current_user's
    # following list.
    @following_tweets = []
    
    # We pull in all the tweets and users...
    @tweets = Tweet.all
    @users = User.all
    
    @follower_count = 0
    
    # Then we sort through the tweets
    # to find ones asscoiated with 
    # users from the current_user's
    # following array.
    if user_signed_in?
      @tweets.each do |tweet|
        current_user.following.each do |f|
          if tweet.user_id == f
            @following_tweets.push(tweet)
            # And those tweets are pushed
            # into the @following_tweets array
            # we added to our view.
          end
        end
      end
      @users.each do |user|
        if user.following.include?(current_user.id)
          @following_count =+ 1
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def now_following
    # This line is just for display purposes:
    @user = User.find(params[:follow_id])
    
    # Here is where the back-end
    # work really happens
    
    current_user.following.push(params[:follow_id].to_i)
    # What we're doing is adding the user.id
    # of the User you want to follow to your
    # 'following' array attribute
    
    current_user.save
    # Then we save it in our database.
    
    redirect_to user_profile_path(id: @user.id)
  end

  def unfollow
    @user = User.find(params[:unfollow_id])
    
    current_user.following.delete(params[:unfollow_id].to_i)
    
    current_user.save
    
    redirect_to user_profile_path(id: @user.id)
  end
  
  def js_practice
    
  end
  
  
end
