import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { TasklistListComponent } from './tasklist/tasklist-list/tasklist-list.component';
import { TasklistCreateComponent } from './tasklist/tasklist-create/tasklist-create.component';
import { TasklistShowComponent } from './tasklist/tasklist-show/tasklist-show.component';
import { AuthService } from './shared/services/auth/auth.service';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  {
    path: 'tasklists',
    component: TasklistListComponent,
    canActivate: [AuthService],
  },
  {
    path: 'tasklists/create',
    component: TasklistCreateComponent,
    canActivate: [AuthService],
  },
  {
    path: 'tasklists/:id',
    component: TasklistShowComponent,
    canActivate: [AuthService],
  },
  { path: '**', redirectTo: 'login' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
