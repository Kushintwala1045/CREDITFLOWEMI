from flask import Flask, request, render_template_string
import math

app = Flask(__name__)

HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>EMI Calculator</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .box {
            background: white;
            padding: 25px;
            width: 350px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
        }
        input {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }
        .result {
            margin-top: 15px;
            padding: 10px;
            background: #e9f7ef;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="box">
        <h2>EMI Calculator</h2>
        <form method="POST">
            <input type="number" step="0.01" name="loan" placeholder="Loan Amount" required>
            <input type="number" step="0.01" name="rate" placeholder="Annual Interest Rate (%)" required>
            <input type="number" name="months" placeholder="Tenure (Months)" required>
            <button type="submit">Calculate EMI</button>
        </form>

        {% if emi %}
        <div class="result">
            <p><b>Monthly EMI:</b> ₹{{ emi }}</p>
            <p><b>Total Payment:</b> ₹{{ total }}</p>
            <p><b>Total Interest:</b> ₹{{ interest }}</p>
        </div>
        {% endif %}
    </div>
</body>
</html>
"""

@app.route("/", methods=["GET", "POST"])
def emi_calculator():
    emi = total = interest = None

    if request.method == "POST":
        P = float(request.form["loan"])
        annual_rate = float(request.form["rate"])
        N = int(request.form["months"])

        R = annual_rate / 12 / 100

        if R == 0:
            emi = P / N
        else:
            emi = P * R * math.pow(1 + R, N) / (math.pow(1 + R, N) - 1)

        total = emi * N
        interest = total - P

        emi = round(emi, 2)
        total = round(total, 2)
        interest = round(interest, 2)

    return render_template_string(HTML, emi=emi, total=total, interest=interest)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
