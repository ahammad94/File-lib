class AggregatesController < ApplicationController
  before_action :set_aggregate, only: [:show, :edit, :update, :destroy, :download]

  # GET /aggregates
  # GET /aggregates.json
  def index
    @aggregates = Aggregate.all
  end

  def download
    send_file(@aggregate.file ,
      :type => @aggregate.file_type,
      :disposition => 'attachment')
  end

  def explore
    @files = []
    @folders = []
    @path = {:full_path=>params[:path], :relative_path => File.basename(params[:path]), :path_array=>params[:path].split("/")}
    @back=""
    if(params[:path] == "home")
      home_path = Dir.home
      @path = {:full_path=>home_path , :relative_path=>home_path, :path_array=>home_path.split("/")}
      @combo = Dir.glob(File.join(home_path,"/*"))
    else
      @back=File.dirname(params[:path])
      @combo = Dir.glob(File.join(params[:path],"/*"))
    end
    @combo.each do |path|
      if(Dir.exists?(path))
        folder= {:path=>path, :name=>File.basename(path),:file_count=>(file_counter(path)), :folder_count=>(folder_counter(path))}
        @folders.push(folder)
      else
        file= {:path=>path, :name=>File.basename(path), :type=>File.extname(path)}
        @files.push(file)
      end
    end
  end

  # GET /aggregates/1
  # GET /aggregates/1.json
  def show
  end

  def search
    @categories = Category.all
  end

  # GET /aggregates/new
  def new
    @aggregate = Aggregate.new
    if (params!=nil)
      @aggregate.file_name = aggregate_params[:file_name]
      @aggregate.file = aggregate_params[:file]
      @aggregate.file_type = aggregate_params[:file_type]
    end
  end

  # GET /aggregates/1/edit
  def edit
  end

  # POST /aggregates
  # POST /aggregates.json
  def create
    @name = aggregate_params[:file_name]
    @path = aggregate_params[:file]
    @type = aggregate_params[:file_type]
    @aggregate = Aggregate.new
    @aggregate.file = @path
    @aggregate.file_type = @type
    @aggregate.file_name = @name

    respond_to do |format|
      if @aggregate.save
        format.html { redirect_to @aggregate, notice: 'Aggregate was successfully created.' }
        format.json { render :show, status: :created, location: @aggregate }
      else
        format.html { render :new }
        format.json { render json: @aggregate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aggregates/1
  # PATCH/PUT /aggregates/1.json
  def update
    respond_to do |format|
      if @aggregate.update(aggregate_params)
        format.html { redirect_to @aggregate, notice: 'Aggregate was successfully updated.' }
        format.json { render :show, status: :ok, location: @aggregate }
      else
        format.html { render :edit }
        format.json { render json: @aggregate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aggregates/1
  # DELETE /aggregates/1.json
  def destroy
    @aggregate.destroy
    respond_to do |format|
      format.html { redirect_to aggregates_url, notice: 'Aggregate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aggregate
      @aggregate = Aggregate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aggregate_params
      params.require(:aggregate).permit(:file_name, :file, :file_type)
    end

    def file_counter(path)
      file_count=0
      path_content = File.join(path,"/*")
      @combo = Dir.glob(path_content)
      @combo.each do |entity|
        if(!Dir.exists?(entity))
          file_count = file_count+1
        end
      end
      file_count
    end
    def folder_counter(path)
      folder_count=0
      path_content = File.join(path,"/*")
      @combo = Dir.glob(path_content)
      @combo.each do |entity|
        if(Dir.exists?(entity))
          folder_count= folder_count+1
        end
      end
      folder_count
    end
end
