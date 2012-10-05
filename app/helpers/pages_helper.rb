module PagesHelper
  def new_for(o,s,i=1)
    t("labels.new_for", o:pl(o,i), s:s)
  end
end
