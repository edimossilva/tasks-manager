import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { TasklistListComponent } from './tasklist/tasklist-list/tasklist-list.component';
import { TasklistCreateComponent } from './tasklist/tasklist-create/tasklist-create.component';
import { TasklistShowComponent } from './tasklist/tasklist-show/tasklist-show.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'tasklists', component: TasklistListComponent },
  { path: 'tasklists/create', component: TasklistCreateComponent },
  { path: 'tasklists/:id', component: TasklistShowComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
