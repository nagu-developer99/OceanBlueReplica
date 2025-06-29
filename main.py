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
def build_llm_context(df_full, start_date, end_date, system_name=None):
    start_date = pd.to_datetime(start_date)
    end_date = pd.to_datetime(end_date)
    duration_days = (end_date - start_date).days + 1

    # Filter date range
    df_period = df_full[(df_full['Execution_Date'] >= start_date) & (df_full['Execution_Date'] <= end_date)]

    # Optionally filter by system name
    if system_name:
        df_period = df_period[df_period['System_Name'].str.lower() == system_name.lower()]

    systems = df_period['System_Name'].unique()
    output = []

    for system in systems:
        df_sys = df_period[df_period['System_Name'] == system]
        zero_dates = df_sys[df_sys['No_Of_Records'] == 0]['Execution_Date'].dt.strftime('%Y-%m-%d').tolist()

        if duration_days <= 14:
            daily_lines = "\n".join(
                f"{d.strftime('%Y-%m-%d')}: {r} records"
                for d, r in zip(df_sys['Execution_Date'], df_sys['No_Of_Records'])
            )
            summary = f"📊 {system} - Daily records:\n{daily_lines}"
        else:
            df_sys['Week'] = df_sys['Execution_Date'].dt.to_period('W').apply(lambda r: r.start_time)
            weekly_avg = df_sys.groupby('Week')['No_Of_Records'].sum().mean()
            summary = f"📈 {system} - Average: {weekly_avg:.1f} records/week"

        if zero_dates:
            summary += f"\n⚠️ Zero-record dates: {', '.join(zero_dates)}"

        output.append(summary)

    return "\n\n".join(output)


