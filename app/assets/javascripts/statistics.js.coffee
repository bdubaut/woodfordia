# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".collapse").collapse()

$.getJSON "/statistics/sex_pie", (data) ->
  ctx = document.getElementById("sex-chart").getContext('2d')
  window.myPie = new Chart(ctx).Pie(data)
  return

$.getJSON "/statistics/virgin_pie", (data) ->
  console.log data
  ctx = document.getElementById("virgin-chart").getContext('2d')
  console.log ctx
  window.myPie = new Chart(ctx).Pie(data)
  return
