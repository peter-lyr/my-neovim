local status, scrollview = pcall(require, "scrollview")
if not status then
  return
end

scrollview.setup({})
