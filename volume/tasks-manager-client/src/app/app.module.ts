import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { TasklistListComponent } from './tasklist-list/tasklist-list.component';
import { TasklistCreateComponent } from './tasklist-create/tasklist-create.component';

@NgModule({
  declarations: [AppComponent, LoginComponent, TasklistListComponent, TasklistCreateComponent],
  imports: [BrowserModule, HttpClientModule, AppRoutingModule, FormsModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
