# 🧪 DAST Automation Target Examples

This repository includes configurations and source code for several well-known **vulnerable example applications**. These are used to provide diverse and challenging targets for scanning and validation by our Dynamic Application Security Testing (DAST) automation tool.

---

### 🌐 Application Sources

The specific application currently being targeted (e.g., using the provided `docker-compose.yml`) may vary, but the base code for these examples is sourced from the following projects:

* **tudo** (Current configuration target example)
    > Source: **[https://github.com/bmdyy/tudo](https://github.com/bmdyy/tudo)**

* **Other Potential Targets:** DVWA, OWASP Juice Shop, bWAPP, etc., are also examples of vulnerable applications intended for use with this DAST automation framework.

* **Purpose:** The example applications are included here strictly for **educational and testing purposes**—specifically, to provide known-vulnerable targets for our DAST automation scripts to scan and validate.

### 🚀 Running Locally (For Windows Users)

The current application (based on the provided **`docker-compose.yml`** file) can be quickly deployed on your local machine using Docker, making it an ideal, isolated environment for testing your DAST tool.

#### Prerequisites

* **Docker Desktop** must be installed and running on your Windows system.
* This process uses the provided **`docker-compose.yml`** file in the root of this repository.

#### Deployment Steps

1.  Navigate to the root directory of this repository in your terminal (Command Prompt, PowerShell, or WSL).
2.  Use the following commands to build the application image and run the containers:

    * **Build the Docker image (Force fresh build):**
        ```bash
        docker-compose build --no-cache
        ```

    * **Start the application in detached mode:**
        ```bash
        docker-compose up -d
        ```

3.  **Access the Application:** Based on the `docker-compose.yml` file in this repository, the application will be accessible in your browser and by your DAST tool at:
    > **`http://localhost:8080`**

---

### 💡 Important Note on Networking

If you plan to run your **DAST automation tool inside a separate Docker container** and need that container to access the application, you must use **`host.docker.internal`** instead of `localhost` in your DAST tool's configuration:

* **URL for DAST Tool (inside a container):** `http://host.docker.internal:8080`

---

### ⚠️ Disclaimer

This code is intended only for controlled security testing (DAST) within isolated environments. **DO NOT** deploy this application publicly.
