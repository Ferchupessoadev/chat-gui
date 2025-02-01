#include <gdk/gdk.h>
#include <glib.h>
#include <gtk/gtk.h>
#include <string.h>

static void activate(GtkApplication *app, gpointer user_data) {
  GtkWidget *window;
  GtkWidget *box;

  window = gtk_application_window_new(app);
  gtk_window_set_title(GTK_WINDOW(window), "ArChat");
  gtk_window_set_default_size(GTK_WINDOW(window), 800, 600);

  box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
  gtk_widget_set_halign(box, GTK_ALIGN_CENTER);
  gtk_widget_set_valign(box, GTK_ALIGN_CENTER);

  gtk_window_set_child(GTK_WINDOW(window), box);

  GtkWidget *label = gtk_label_new("Hola Mundo");

  gtk_box_append(GTK_BOX(box), label);

  gtk_window_present(GTK_WINDOW(window));
}

int main(int argc, char **argv) {
  GtkApplication *app;
  int status;

  app = gtk_application_new("org.gtk.example", G_APPLICATION_DEFAULT_FLAGS);
  g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);
  status = g_application_run(G_APPLICATION(app), argc, argv);
  g_object_unref(app);

  return status;
}
