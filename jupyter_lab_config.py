c = get_config()

# Persist user settings
c.ServerApp.root_dir = '/opt/workspace'
c.ServerApp.terminado_settings = {
    'shell_command': ['/bin/bash']
}

# Configure to allow persistence of settings
c.LabApp.user_settings_dir = '/root/.jupyter/lab/user-settings'
c.LabApp.workspaces_dir = '/root/.jupyter/lab/workspaces'

# Enable collaborative mode (if needed)
c.ServerApp.collaborative = True

# Default kernel 
c.LabApp.default_url = '/lab'

# Disable token for simplicity (you may want to change this in production)
c.ServerApp.token = ''
c.ServerApp.password = '' 