class ImagesController < ApplicationController
  # GET /images
  # GET /images.xml
  def index
    @images = Image.all
    @image = Image.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    @image = Image.new(params[:image])
    @image.title = params[:image][:title] || params[:qqfile]
    
    #######
    # get file name
    file_name = params[:qqfile]
    # get file content type
    att_content_type = (request.content_type.to_s == "") ? "application/octet-stream" : request.content_type.to_s
    # create temporal file
    file = Tempfile.new(file_name)
    # put data into this file from raw post request
    file.print request.raw_post
   
    # create several required methods for this temporal file
    Tempfile.send(:define_method, "content_type") {return att_content_type}
    Tempfile.send(:define_method, "original_filename") {return file_name}

    @image.avatar = file
    #########

    respond_to do |format|
      if @image.save
        format.html { redirect_to(@image, :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
        format.js do
          render :template => "images/list_item.json.erb", :locals => {
            :id => @image.id,
            :partial => "images/list_item.html.erb",
            :locals => {:image => @image} 
          }, :status => 200
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
  
  def destroy_all
    @images = Image.all
    for image in @images
      image.destroy
    end
    redirect_to(images_url)
  end
end
