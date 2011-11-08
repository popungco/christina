class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @image = @post.images.build
    #3.times { @image = @post.images.build }
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    logger.info "New post: #{@post.attributes.inspect}"
    
    respond_to do |format|
      if @post.save 
        @post.images.each { |image| image.save! }
        format.html {
          flash[:notice] = 'Post was successfully created.'
          logger.debug "The post was saved and now the user is going to be redirected..."
          redirect_to(@post)
          
          #redirect_to @post, notice: 'Post was successfully created.'
        }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        #update_images(@post.images)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        logger.debug "debug3: #{@post.errors}"

        logger.debug "debug4: #{@post.errors}"
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_images(images)
    images.each { |image|
      #logger.info "changed images: #{image.marked_for_destruction?}"
        image.update_attributes!
       }
  end
  
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
