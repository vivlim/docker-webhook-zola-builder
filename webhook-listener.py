from flask import Flask, request, Response
import logging
import subprocess

app = Flask(__name__)

logging.basicConfig(level=logging.DEBUG)

@app.route('/webhook', methods=['POST'])
def respond():
    app.logger.info("Handling request.")
    result = subprocess.run(['/on_request.sh'], capture_output=True)
    result_stdout = result.stdout.decode('utf-8')
    app.logger.info(result_stdout)
    if result.returncode == 0:
        return Response(status=200)
    else:
        return Response(status=500)
