-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Auto-resolve the "swap file already exists" prompt, but only when it's safe.
-- HPC jobs get killed by walltime before nvim exits cleanly, orphaning swaps.
-- Delete a swap ONLY when its owning nvim is truly gone:
--   * owner alive on this host            -> open read-only (don't touch a live session)
--   * swap recorded unsaved edits (dirty) -> fall through to the prompt so you can :recover
--   * otherwise (dead pid / another node) -> delete and edit normally
vim.api.nvim_create_autocmd("SwapExists", {
  desc = "Delete swap only if its owning nvim is gone and it has no unsaved changes",
  callback = function()
    local info = vim.fn.swapinfo(vim.v.swapname)
    if info.error and info.error ~= "" then return end -- unreadable: let me decide
    if info.dirty == 1 then return end -- unsaved changes: prompt to recover
    local comm = info.pid and info.pid > 0 and ("/proc/%d/comm"):format(info.pid) or nil
    local alive = info.host == vim.fn.hostname()
      and comm
      and vim.fn.filereadable(comm) == 1
      and vim.trim((vim.fn.readfile(comm)[1] or "")) == "nvim"
    vim.v.swapchoice = alive and "o" or "d"
  end,
})
