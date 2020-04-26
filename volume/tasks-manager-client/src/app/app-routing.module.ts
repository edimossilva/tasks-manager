import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { TasklistListComponent } from './tasklist-list/tasklist-list.component';
import { TasklistCreateComponent } from './tasklist-create/tasklist-create.component';
const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'tasklists', component: TasklistListComponent },
  { path: 'tasklists/create', component: TasklistCreateComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
