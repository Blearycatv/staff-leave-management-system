﻿using Sunny.UI.Demo.Properties;
using System;

namespace Sunny.UI.Demo
{
    public partial class FListBox : UITitlePage
    {
        public FListBox()
        {
            InitializeComponent();
        }

        public override void Init()
        {
            uiListBox1.Items.Clear();
            for (int i = 0; i < 50; i++)
            {
                uiListBox1.Items.Add(i);
            }

            uiImageListBox1.Items.Clear();
            // string[] files = System.IO.Directory.GetFiles(DirEx.CurrentDir() + "Team",
            //     "*.png", SearchOption.TopDirectoryOnly);
            // foreach (string file in files)
            // {
            //     uiImageListBox1.AddImage(file, file.FileInfo().Name);
            //     Console.WriteLine(file.FileInfo().Name);
            // }

            uiImageListBox1.AddImage(Resources.ajax, "ajax.png");
            uiImageListBox1.AddImage(Resources.atalanta, "atalanta.png");
            uiImageListBox1.AddImage(Resources.barcelona, "barcelona.png");
            uiImageListBox1.AddImage(Resources.benfica, "benfica.png");
            uiImageListBox1.AddImage(Resources.betis, "betis.png");
            uiImageListBox1.AddImage(Resources.brescia, "brescia.png");
            uiImageListBox1.AddImage(Resources.chievo, "chievo.png");
            uiImageListBox1.AddImage(Resources.deportivo, "deportivo.png");
            uiImageListBox1.AddImage(Resources.feyenoord, "feyenoord.png");
            uiImageListBox1.AddImage(Resources.heerenveen, "heerenveen.png");
            uiImageListBox1.AddImage(Resources.inter, "inter.png");
            uiImageListBox1.AddImage(Resources.lazio, "lazio.png");
            uiImageListBox1.AddImage(Resources.mallorca, "mallorca.png");
            uiImageListBox1.AddImage(Resources.milan, "milan.png");
            uiImageListBox1.AddImage(Resources.parma, "parma.png");
            uiImageListBox1.AddImage(Resources.porto, "porto.png");
            uiImageListBox1.AddImage(Resources.psv, "psv.png");
            uiImageListBox1.AddImage(Resources.real_madrid, "real_madrid.png");
            uiImageListBox1.AddImage(Resources.real_sociedad, "real_sociedad.png");
            uiImageListBox1.AddImage(Resources.roma, "roma.png");
            uiImageListBox1.AddImage(Resources.sevilla, "sevilla.png");
            uiImageListBox1.AddImage(Resources.udinese, "udinese.png");
            uiImageListBox1.AddImage(Resources.valencia, "valencia.png");
            uiImageListBox1.AddImage(Resources.villareal, "villareal.png");
            uiImageListBox1.AddImage(Resources.zaragoza, "zaragoza.png");
        }

        private void uiImageListBox1_ItemDoubleClick(object sender, System.EventArgs e)
        {
            this.ShowInfoDialog(uiImageListBox1.SelectedItem.ImagePath);
        }

        private void uiCheckBox1_ValueChanged(object sender, bool value)
        {
            uiImageListBox1.ShowDescription = !uiImageListBox1.ShowDescription;
            uiImageListBox1.ItemHeight = uiImageListBox1.ShowDescription ? 80 : 50;
        }

        private void uiListBox1_ItemDoubleClick(object sender, System.EventArgs e)
        {
            this.ShowInfoDialog(uiListBox1.SelectedItem.ToString());
        }

        private int num = 0;
        private void uiButton1_Click(object sender, System.EventArgs e)
        {
            uiListBox1.Items.Add(DateTime.Now.ToString("yyyyMMdd") + "_" + num);
            num++;
        }

        private void uiButton1_DoubleClick(object sender, EventArgs e)
        {
            uiListBox1.Items.Add(DateTime.Now.ToString("yyyyMMdd") + "_double_" + num);
            num++;
        }
    }
}