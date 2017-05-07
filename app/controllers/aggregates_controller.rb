class AggregatesController < ApplicationController
  before_action :set_aggregate, only: [:show, :edit, :update, :destroy, :download]

  # GET /aggregates
  # GET /aggregates.json
  def index
    if(params[:orderby] == nil)

      @orderby = 'created_at'

    else

      @orderby=params[:orderby]

    end
    
    @categories = Category.all
    @aggregates = Aggregate.order('LOWER('+ @orderby + ')')
    
  end

  def parse_online
    @page = Nokogiri::XML(open(params[:online_aggregate][:file]))
    @page.traverse {|node| p node['V']}

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
    @subcategories = Array.new
    @filecategories = @aggregate.categories
    @filesubcategories = @aggregate.subcategories
    @categories = Category.all
    for cat in @filecategories
      for subcat in cat.subcategories
        if !@filesubcategories.include?(subcat) 
          @subcategories.push(subcat)
        end
      end
    end
  end

  def add_category
    @aggregate = Aggregate.find(aggregate_category_params[:aggregate_id])
    @category = Category.find(aggregate_category_params[:category_id])
    @aggregate.categories << @category
    respond_to do |format|
      if(@aggregate.save)
        format.html { redirect_to @aggregate, notice: 'Category was successfully added' }
      else
        format.html { redirect_to @aggregate, notice: 'Category could not be added' }
      end
    end
  end

  def add_subcategory
    @aggregate = Aggregate.find(aggregate_subcategory_params[:aggregate_id])
    @subcategory = Subcategory.find(aggregate_subcategory_params[:subcategory_id])
    @aggregate.subcategories << @subcategory
    respond_to do |format|
      if(@aggregate.save)
        format.html { redirect_to @aggregate, notice: 'Subcategory was successfully added' }
      else
        format.html { redirect_to @aggregate, notice: 'Subategory could not be added' }
      end
    end
  end

  def remove_category
    @aggregate = Aggregate.find(aggregate_category_params[:aggregate_id])
    @category = Category.find(aggregate_category_params[:category_id])
    @aggregate.categories.delete(@category)
    for subcat in @category.subcategories
      @aggregate.subcategories.delete(subcat)
    end
    respond_to do |format|
      if(@aggregate.save)
        format.html { redirect_to @aggregate, notice: 'Category was successfully removed' }
      else
        format.html { redirect_to @aggregate, notice: 'Category could not be removed' }
      end
    end
  end

  def remove_subcategory
    @aggregate = Aggregate.find(aggregate_subcategory_params[:aggregate_id])
    @subcategory = Subcategory.find(aggregate_subcategory_params[:subcategory_id])
    @aggregate.subcategories.delete(@subcategory)

    respond_to do |format|
      if(@aggregate.save)
        format.html { redirect_to @aggregate, notice: 'Subcategory was successfully removed' }
      else
        format.html { redirect_to @aggregate, notice: 'SubCategory could not be removed' }
      end
    end
  end

  def search
    @orderby = 'created_at'
    sql = "
    Select aggregates.* 
    from aggregates, aggregates_categories, categories
    where aggregates.id = aggregates_categories.aggregate_id
    AND categories.id = aggregates_categories.category_id
    AND aggregates.file_name like '%%'"
    @aggregates = Aggregate.find_by_sql(sql)
    @categories = Category.all
    respond_to do |format|
      format.html { render :index }
    end 
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

  def newOnline
    @aggregate = Aggregate.new
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
    @aggregate.guid = SecureRandom.uuid

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

  def create_folder
    @aggregate = Aggregate.new
    @aggregate.file = 'local'
    @aggregate.file_name= folder_params[:name]
    @aggregate.file_type = 'folder'
    @aggregate.guid = SecureRandom.uuid
    respond_to do |format|
      if @aggregate.save
        format.html { redirect_to @aggregate, notice: 'Aggregate was successfully created.' }
      else
        format.html { render :index }
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

    def aggregate_category_params
      params.require(:aggregate_category).permit(:aggregate_id, :category_id)
    end


    def aggregate_subcategory_params
      params.require(:aggregate_category).permit(:aggregate_id, :subcategory_id)
    end

    def folder_params
      params.require(:folder).permit(:name)
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
