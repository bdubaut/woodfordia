class StatisticsController < ApplicationController
  before_action :authenticate_user!

  def index
    @adventures = Adventure.all.entries
    @users = User.with_role(:player).all.entries

  end

  def sex_chart
    @men = User.with_role(:player).where(sex: 'M').count
    @women = User.with_role(:player).where(sex: 'F').count
    @other = User.with_role(:player).where(sex: "Other").count
    data = [
      {
        value: @men,
        color:"#1b96d3",
        highlight: "#00a9ff",
        label: "Men"
      },
      {
        value: @women,
        color:"#e84edd",
        highlight: "#f489eb",
        label: "Women"
      },
      {
        value: @other,
        color:"#FDB45C",
        highlight: "#FFC870",
        label: "Other"
      },
    ]
    render json: data
  end

  def virgin_chart
    @virgins = User.with_role(:player).where(first_time: true).count
    @non_virgins = User.with_role(:player).where(first_time: false).count
    data = [
      {
        value: @virgins,
        color: '#CBDDE6',
        highlight: '#CBDDE6',
        label: 'Virgins'
      },
      {
        value: @non_virgins,
        color: '#EEEEEE',
        highlight: '#EEEEEE',
        label: 'Returning players'
      },
    ]
    render json: data
  end

  def age_chart
    data = {
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [
        {
          label: "My First dataset",
          fillColor: "rgba(220,220,220,0.5)",
          strokeColor: "rgba(220,220,220,0.8)",
          highlightFill: "rgba(220,220,220,0.75)",
          highlightStroke: "rgba(220,220,220,1)",
          data: [65, 59, 80, 81, 56, 55, 40]
        },
        {
          label: "My Second dataset",
          fillColor: "rgba(151,187,205,0.5)",
          strokeColor: "rgba(151,187,205,0.8)",
          highlightFill: "rgba(151,187,205,0.75)",
          highlightStroke: "rgba(151,187,205,1)",
          data: [28, 48, 40, 19, 86, 27, 90]
        }
      ]
      }
    @users = User.with_role(:player).order_by(:age.asc).entries

    render json: data
  end
end
