class Folder < ActiveRecord::Base
  belongs_to :parent, :class_name => "Folder", :foreign_key => "parent_id"
  has_many :subfolders, :class_name => "Folder"
  has_many :permission_for_folders, :dependent => :destroy
  has_many :users, :through => :permission_for_folders
  
  
  COURSE_LEVEL = "kierunek"
  SEMESTER_LEVEL = "semestr"
  CLASS_LEVEL = "przedmiot"
  
  ALL_LEVELS = [COURSE_LEVEL, SEMESTER_LEVEL, CLASS_LEVEL]
  
  validates_inclusion_of :level, :in => ALL_LEVELS
end
