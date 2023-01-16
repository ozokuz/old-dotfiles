local settings = {
  terminal = 'alacritty',
  editor = os.getenv('EDITOR') or 'nvim',
  browser = os.getenv('BROWSER') or 'brave',
  task_manager = 'btop',
  gui_file_manager = 'nemo',
}

return settings
