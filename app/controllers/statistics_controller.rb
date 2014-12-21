class StatisticsController < ApplicationController
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
end
