ATROX VECTRA



ATROX VECTRA is a backend platform focused on the dynamic and version-controlled management of application components (companies, users, screens, actions, and menus), designed with a database-driven structural versioning model.



The system provides controlled enable/disable mechanisms, rollback capabilities, standardized database procedures, and installation automation for enterprise environments.



🚀 Core Features

🔹 Structural Versioning Model



Real version control for screens



Enable / Disable version switching



Rollback support



Controlled status transitions (ENABLED / DISABLED / ROLLBACK)



Current version reference stored at entity level



🔹 Standardized Stored Procedures



All procedures follow a strict contract:



Input parameters prefixed with: @i\_



Output parameters prefixed with: @o\_



Mandatory outputs:



@o\_error



@o\_message



Default behavior:



@o\_error = 0



@o\_message = 'OK'



🔹 Full Reprocessable SQL Scripts



All database objects:



Validate existence



Drop if exists



Recreate object



Print standardized execution messages:



<<<DROPPED TABLE ATROX.table\_name>>>

<<<CREATED PROCEDURE ATROX.proc\_name>>>

<<<FAILED CREATING FUNCTION ATROX.func\_name>>>





This allows:



Safe re-execution



Log parsing



CI/CD compatibility



Deployment traceability



🔹 Hybrid Database Support



Microsoft SQL Server



PostgreSQL



Directory structure:



/SQLServer

/PostgreSQL





Each engine contains:



Tables/

Procedures/

Functions/

Views/

Seeds/

00\_Run\_All.sql



🛠 Installation



The project includes a PowerShell installer:



install.ps1



Installer Capabilities



Engine selection (SQL Server / PostgreSQL)



SQL Authentication



Windows Authentication (SQL Server)



Default port handling



Connection validation



Database empty validation



Execution logging



Exit codes for pipeline usage



Requirements



SQL Server + sqlcmd

or



PostgreSQL + psql



PowerShell 5+



Run

.\\install.ps1





The installer:



Validates connection



Verifies database is empty



Executes 00\_Run\_All.sql



Generates log file



Returns success/failure status



📦 Deployment Model



ATROX VECTRA follows:



Clean installation model



Controlled structural upgrades



Reprocessable object scripts



Log-driven traceability



Recommended future structure:



Releases/

&nbsp;   1.1.0\_upgrade.sql

&nbsp;   1.2.0\_upgrade.sql



🔐 Governance \& Control



All structural changes occur via stored procedures



Version activation is transactional



Rollback operations preserve system consistency



Audit model supports structural traceability



🧱 Architecture Principles



Database-driven state control



Explicit version enablement



No implicit updates on published versions



Deterministic deployment



Enterprise-grade error handling



📄 License



Private project – ATROX VECTRA.

