import pandas as pd

data = {
    'date': pd.date_range(start='2024-07-01', periods=21, freq='D'),
    'records': [100, 80, 85, 90, 95, 78, 88, 92, 85, 90, 87, 91, 95, 94, 89, 87, 85, 80, 78, 82, 90]
}
df = pd.DataFrame(data)


from dash import Dash, dcc, html
from dash.dependencies import Input, Output
import plotly.express as px

# Initialize the Dash app
app = Dash(__name__)

# Generate week ranges for dropdown options
def generate_week_ranges(start_date, num_weeks):
    weeks = []
    current_start = start_date
    for _ in range(num_weeks):
        current_end = current_start + pd.Timedelta(days=6)
        weeks.append(f"{current_start.strftime('%d-%b-%y')} to {current_end.strftime('%d-%b-%y')}")
        current_start = current_end + pd.Timedelta(days=1)
    return weeks

# Create week ranges
start_date = pd.to_datetime('2024-07-01')
week_ranges = generate_week_ranges(start_date, num_weeks=3)

# Layout of the Dash app
app.layout = html.Div([
    dcc.Dropdown(
        id='week-dropdown',
        options=[{'label': week, 'value': week} for week in week_ranges],
        value=week_ranges[0]
    ),
    dcc.Graph(id='line-chart')
])

# Callback to update the graph based on the selected week
@app.callback(
    Output('line-chart', 'figure'),
    [Input('week-dropdown', 'value')]
)
def update_graph(selected_week):
    start_date_str, end_date_str = selected_week.split(' to ')
    start_date = pd.to_datetime(start_date_str, format='%d-%b-%y')
    end_date = pd.to_datetime(end_date_str, format='%d-%b-%y')
    filtered_df = df[(df['date'] >= start_date) & (df['date'] <= end_date)]
    fig = px.line(filtered_df, x='date', y='records', title=f'Records from {selected_week}')
    return fig

if __name__ == '__main__':
    app.run_server(debug=True)
