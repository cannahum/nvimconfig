function ColorMyPencils(color)
    print(color)
    color = color or 'rose-pine-main'
    vim.cmd.colorscheme(color)
end

ColorMyPencils()
