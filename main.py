from flask import Flask, jsonify, render_template
import time

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/execute/<callable_name>', methods=['POST'])
def execute_callable(callable_name):
    functions = {
        "InjectMessage": InjectMessage,
        "ProcessMessage": ProcessMessage,
        "StampMessagesToDB": StampMessagesToDB,
        "ValidateDB": ValidateDB
    }
    if callable_name in functions:
        log = functions[callable_name]()
        return jsonify({"status": "success", "log": log})
    else:
        return jsonify({"status": "error", "message": "Invalid callable name"})

def InjectMessage():
    time.sleep(1)
    return "InjectMessage executed"

def ProcessMessage():
    time.sleep(1)
    return "ProcessMessage executed"

def StampMessagesToDB():
    time.sleep(1)
    return "StampMessagesToDB executed"

def ValidateDB():
    time.sleep(1)
    return "ValidateDB executed"

if __name__ == '__main__':
    app.run(debug=True)

##########################
def build_llm_context(df_full, system_name, start_date, end_date):
    # Parse dates
    start_date = pd.to_datetime(start_date)
    end_date = pd.to_datetime(end_date)
    duration_days = (end_date - start_date).days + 1

    # Filter data
    df_sys = df_full[df_full['System_Name'].str.lower() == system_name.lower()]
    df_period = df_sys[(df_sys['Execution_Date'] >= start_date) & (df_sys['Execution_Date'] <= end_date)]

    # Identify zero-record dates
    zero_dates = df_period[df_period['No_Of_Records'] == 0]['Execution_Date'].dt.strftime('%Y-%m-%d').tolist()

    # Prepare message
    if duration_days <= 14:
        # Daily records
        rows = df_period.sort_values('Execution_Date')
        daily_lines = "\n".join(f"{d.strftime('%Y-%m-%d')}: {r} records"
                                for d, r in zip(rows['Execution_Date'], rows['No_Of_Records']))
        summary = f"Daily record summary for {system_name} from {start_date.date()} to {end_date.date()}:\n{daily_lines}"
    else:
        # Weekly average
        df_period['Week'] = df_period['Execution_Date'].dt.to_period('W').apply(lambda r: r.start_time)
        weekly_avg = df_period.groupby('Week')['No_Of_Records'].sum().mean()
        summary = f"{system_name} created an average of {weekly_avg:.1f} records per week from {start_date.date()} to {end_date.date()}."

    # Add 0-record dates
    if zero_dates:
        summary += f"\n\n⚠️ Days with 0 records: {', '.join(zero_dates)}"

    return summary

