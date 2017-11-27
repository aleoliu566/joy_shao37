module CompaniesHelper

  def analysis_chart(company)
    pie_chart company.jobs.group(:views_count).count, library:{
      title: {text:'dddd'},
      yAxis: {
         allowDecimals: false,
         title: {
             text: 'Ages count'
         },
      },
      xAxis: {
         title: {
             text: 'Age'
         }
      }
    }
  end

end
